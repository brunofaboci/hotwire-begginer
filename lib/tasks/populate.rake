require 'populator'

namespace :populate do
  desc 'create companies'
  task :companies => :environment do
    Company.create(name: 'KPMG')
    Company.create(name: 'PWC')
  end

  desc 'create quotes'
  task :quotes => :environment do
    Quote.create(name: 'First quote', company_id: Company.first.id)
    Quote.create(name: 'Second quote', company_id: Company.first.id)
    Quote.create(name: 'Third quote', company_id: Company.last.id)
  end

  desc 'create users'
  task :users => :environment do
    User.create(email: 'accountant@kpmg.com', encrypted_password: 'qwerty', company_id: Company.first.id)
    User.create(email: 'manager@kpmg.com', encrypted_password: 'qwerty', company_id: Company.first.id)
    User.create(email: 'eavesdropper@pwc.com', encrypted_password: 'qwerty', company_id: Company.last.id)
  end
end
