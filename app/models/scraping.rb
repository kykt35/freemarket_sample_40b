
require 'Mechanize'

class Scraping
  def self.get_categories

    agent = Mechanize.new
    page = agent.get('https://www.mercari.com/jp/')

    categories=page.search('.pc-header-nav-parent')
    categories.each_with_index do |category|
      category_1 = category.at('a').inner_text
      sub_categories = category.search('.pc-header-nav-child')
      sub_categories.each do |sub|
        category_2 = sub.at('a').inner_text
        subsub_categories = sub.search('.pc-header-nav-grand-child')
        subsub_categories.each do |subsub|
          category_3 = subsub.at('a').inner_text
          puts " #{category_1}, #{category_2}, #{category_3}"
        end
      end
    end
  end
end

