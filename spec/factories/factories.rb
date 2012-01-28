Factory.define :organization do |f|
  f.name "Test Org"
  f.state "ME"
  f.population 1234
end

Factory.define :project do |f|
  f.year Time.now.year
  f.expense_budget 0
  f.revenue_budget 0
end