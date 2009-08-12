namespace 'culerity' do
  namespace 'rails' do
    desc "Starts a rails server for cucumber/culerity tests"
    task :start => :environment do
      environment = 'culerity_development'
      pid_file = RAILS_ROOT + "/tmp/culerity_rails_server.pid"
      if File.exists?(pid_file)
        puts "culerity rails server already running; if not, delete tmp/culerity_rails_server.pid and try again"
        exit 1
      end
      rails_server = IO.popen("script/server -e #{environment} -p 3001", 'r+')
      File.open(pid_file, "w") { |file| file << rails_server.pid }
    end

    desc "Stops the running rails server for cucumber/culerity tests"
    task :stop => :environment do
      pid_file = RAILS_ROOT + "/tmp/culerity_rails_server.pid"
      if File.exists?(pid_file)
        pid = File.read(pid_file).to_i
        Process.kill(6, pid)
        File.delete(pid_file)
      else
        puts "No culerity rails server running. Doing nothing."
      end
    end
  end
end
