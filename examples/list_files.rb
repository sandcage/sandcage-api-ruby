require "sandcage"

# Save the API_KEY to your home directory as a file named
# SANDCAGE_API_KEY
api_key_dir = File.expand_path("~")
api_key_file = File.join(api_key_dir, "SANDCAGE_API_KEY")
api_key = IO.readlines(api_key_file)[0]

sc = Sandcage::Client.new(api_key)

# Payload with conditional request_id
payload = { directory: "root", # optional
            page: 1, # optional
            results_per_page: 100 # optional
          }

result = sc.list_files_service(payload)
if result.code != 200
  puts "Http error occured with status code #{result.response[:code]}."
else
  parsed_response = result.parsed_response
  puts "Status: #{parsed_response["status"]}"
  puts "Request_Id: #{parsed_response["request_id"]}"
  # Success or warning
  if parsed_response["status"] == "success" || parsed_response["status"] == "warning"
    # In case of warning, print out the warning messages
    if parsed_response["status"] == "warning"
        parsed_response["warning_msg"].each do |msg|
         msg.each do |key, value|
           puts "#{key}: #{value}"
         end
       end    
    end

    # Print out the files
    parsed_response["files"].each do |msg|
      msg.each do |key, value|
        puts "#{key}: #{value}"
      end
      puts ""
    end
  elsif parsed_response["status"] == "error"
    # In case of warning, print out the warning messages
    if parsed_response["status"] == "error"
        parsed_response["error_msg"].each do |msg|
         msg.each do |key, value|
           puts "#{key}: #{value}"
         end
       end    
    end
  else
    puts "Unexpected status."
  end
end
