namespace :dev do
  desc "Preparing the database for development environment."
  task setup: :environment do
    if Rails.env.development?
      perform_action_with_spinner("Delete database") do
        %x(rails db:drop)
      end
      perform_action_with_spinner("Create database") do
        %x(rails db:create)
      end
      perform_action_with_spinner("Migrate database") do
        %x(rails db:migrate)
      end
      perform_action_with_spinner("Populate database") do
        %x(rails dev:populate_mining_type)
      end
    else
      puts("Operation not allowed.")
    end
  end

  desc "Populate table 'MiningType' in database."
  task populate_mining_type: :environment do
    if Rails.env.development?
      perform_action_with_spinner("Populating table 'Mining Type'") do
        mining_types = [
          {
            description:"Proof of Work",
            acronym:"PoW"
          },{
            description:"Proof of Capacity",
            acronym:"PoC"
          },{
            description:"Proof of Stake",
            acronym:"PoS"
          }
        ]
        mining_types.each  {|mining_type|
          MiningType.find_or_create_by(mining_type)
        }
      end
    else
      puts("Operation not allowed.")
    end
  end

  private
  def perform_action_with_spinner(start_message="Perform Action", end_message="Completed Action")
    spinner = TTY::Spinner.new("[:spinner] " + start_message.to_s)
    spinner.auto_spin
    yield
    spinner.success("(" + end_message.to_s + ")")
  end
end
