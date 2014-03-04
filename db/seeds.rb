#!/bin/env ruby
# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if User.find_by_email("admin@gmail.com").nil?
  User.create!(email: 'admin@gmail.com', password: '11111111', password_confirmation: '11111111', role: 'admin')
end

QuestionLevel.create!(name:"简单")
QuestionLevel.create!(name:"一般")
QuestionLevel.create!(name:"困难")
QuestionLevel.create!(name:"非常难")
