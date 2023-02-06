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
        %x(rails dev:populate_coin)
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

  desc "Populate table 'Coin' in database."
  task populate_coin: :environment do
    if Rails.env.development?
      perform_action_with_spinner("Populating table 'Coin'") do
        coins = [
          {
            description:"BitCoin",
            acronym: "BTC",
            url_image: "https://pngimg.com/uploads/bitcoin/bitcoin_PNG47.png",
            mining_type: MiningType.find_by(acronym:"PoW")
          },
          {
            description:"Ethereum",
            acronym: "ETH",
            url_image: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Ethereum_logo_2014.svg/294px-Ethereum_logo_2014.svg.png",
            mining_type: MiningType.find_by(acronym:"PoS")
          },
          {
            description:"Cardano",
            acronym: "ADA",
            url_image: "https://logospng.org/wp-content/uploads/cardano.png",
            mining_type: MiningType.find_by(acronym:"PoS  ")
          },
          {
            description:"DASH",
            acronym: "DASH",
            url_image: "https://s2.coinmarketcap.com/static/img/coins/64x64/131.png",
            mining_type: MiningType.find_by(acronym:"PoW")
          },
          {
            description:"Burst",
            acronym: "SIGNA",
            url_image: "https://s2.coinmarketcap.com/static/img/coins/64x64/573.png",
            mining_type: MiningType.find_by(acronym:"PoC")
          },
          {
            description:"Doge",
            acronym: "DOGE  ",
            url_image: "https://s2.coinmarketcap.com/static/img/coins/64x64/74.png",
            mining_type: MiningType.find_by(acronym:"PoW")
          }
        ]

        coins.each do |coin|
          Coin.find_or_create_by(coin)
        end
      end
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
