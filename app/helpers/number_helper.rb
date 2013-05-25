# -*- coding: utf-8 -*-

module NumberHelper
  def number_to_chinese(number)
    single_numbers = ['', '一', '二', '三', '四', '五', '六', '七', '八', '九']
    multiples = ['', '十', '百', '千', '万']
    result = []
    number.to_s.split(//).map(&:to_i).each { |i| single_numbers[i] }.reverse.each_with_index { |i, index| result << ((i == 1 && index == 1) ? "#{multiples[index]}" : "#{single_numbers[i]}#{multiples[index]}") }
    result.reverse.join
  end
end
