FactoryBot.define do
  sequence :email_address do |n|
    "person#{n}@experiment.com"
  end
end
