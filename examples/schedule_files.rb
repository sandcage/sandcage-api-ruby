require "sandcage"

# Save the API_KEY to your home directory as a file named
# SANDCAGE_API_KEY
api_key_dir = File.expand_path("~")
api_key_file = File.join(api_key_dir, "SANDCAGE_API_KEY")
api_key = IO.readlines(api_key_file)[0]

sc = Sandcage::Client.new(api_key)

# Payload with conditional request_id
payload = { jobs: [
              { url: "http://cdn.sandcage.com/p/a/img/logo.jpg",
                tasks: [
                  { actions: "save" },
                  { actions: "resize",
                    filename: "hello_world.jpg",
                    width: 200},
                  { actions: "crop",
                    coords: "10,10,50,50"},
                  { reference_id: "1234567890",
                    actions: "rotate",
                    degrees: 90},
                  { actions: "cover",
                    width: 60,
                    height: 60,
                    cover: "middle,center"}]},
              { url: "http://cdn.sandcage.com/p/a/img/header_404.png",
                tasks: [
                  { actions: "resize",
                    height: 30}]}]}
result = sc.schedule_files_service(payload)
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

    # Print out the tasks
    parsed_response["tasks"].each do |msg|
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
