require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_phone_number(phone_str)
  phone_str.gsub!(/\D/, "")

  if (phone_str.length < 10)
    phone_str = 'bad number'
  elsif (phone_str.length == 11)
    if (phone_str[0] == '1')
      phone_str = phone_str[1..phone_str.length]
    else
      phone_str = 'bad number'
    end
  elsif(phone_str.length > 11)
    phone_str = 'bad number'
  end
  phone_str
end

def peak_registration_hours(reg_dates_strs)
  #turn reg_date_strs to DateTime objects and store each hour on reg_hours
  reg_hours = reg_dates_strs.map do |date_str|
    DateTime.strptime(date_str, '%m/%d/%Y %H:%M').hour
  end

  #count occurences of each element in reg_hours
  hour_occur = reg_hours.reduce(Hash.new(0)) do |acc, cur|
    acc[cur] += 1
    acc
  end

  #sort hash by value
  hour_occur.sort_by{|k, v| -v}
end

def peak_registration_days(reg_dates_strs)
  #turn reg_dates_strs to Date objects and store each week day in reg_days
  reg_days = reg_dates_strs.map do |date_str|
    week_day = Date.strptime(date_str, '%m/%d/%Y %H:%M').wday
    case week_day
    when 0
      'Sunday'
    when 1
      'Monday'
    when 2
      'Tuesday'
    when 3
      'Wednesday'
    when 4
      'Thursday'
    when 5
      'Friday'
    when 6
      'Saturday'
    end
  end

  #count occurrences of each element in reg_days
  days_occur = reg_days.reduce(Hash.new(0)) do |acc, cur|
    acc[cur] += 1
    acc
  end

  #sort hash by value
  days_occur.sort_by{|k, v| -v}
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")

  filename = "output/thanks_#{id}.html"

  File.open(filename,'w') do |file|
    file.puts form_letter
  end
end

puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
reg_dates = []

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)
  phone_number = clean_phone_number(row[:homephone].to_s)
  reg_dates.push(row[:regdate])

  #form_letter = erb_template.result(binding)

  #save_thank_you_letter(id,form_letter)
end

#p peak_registration_hours(reg_dates)
p peak_registration_days(reg_dates)


