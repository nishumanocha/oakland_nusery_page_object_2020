require 'rspec'
require 'page-object'
require 'data_magic'


World(PageObject::PageFactory)

$env = ENV['environment']

app_url = "http://plants.oaklandnursery#{$env}.com/12130001"

#OR
if ENV['environment'].nil?
  $env = 'qa'
end
#app_url = "http://plants.oaklandnursery#{$env}.com/12130001"
$app_url = "http://plants.oaklandnursery.com/12130001"

if ENV['environment'].nil?
  $browser_type = :chrome
end

$file_path = 'features/support/test data/test_data.yml'
$test_data = YAML.load_file $file_path