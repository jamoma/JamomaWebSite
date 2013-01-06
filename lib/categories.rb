module Categories
  extend Nanoc::Memoization

  # Collect all categories from articles
  #
  # :call-seq:
  #   all_categories(array) -> array
  #   all_categories(array, posts) -> array
  #
  # By default all posts are scanned. Add a collection to limit the
  # posts scanned. The items in the array are Nanoc::Items where the
  # +kind+ is +article+
  #
  # Returns an array of strings with the name of categories on those posts.
  def all_categories(posts=sorted_articles)
    cats = []
    posts.each do |article|
      next if article[:categories].nil?
      cats << article[:categories]
    end
    cats.flatten.sort_by { |x| x.downcase }.compact.uniq
  end
  memoize :all_categories

  # Check if a given article has a category
  #
  # :call-seq: has_category?(category, article) -> boolean
  def has_category?(category, article)
    if article[:categories].nil?
      false
    else
      article[:categories].include?(category)
    end
  end

  # Find all articles with a specific category.
  #
  # :call-seq:
  #   articles_with_category(category) -> array
  #   articles_with_category(category, posts) -> array
  #
  # By default all articles are checked. Pass in an array to limit the
  # search to a subset of articles.
  def articles_with_category(category, posts=sorted_articles)
    posts.select { |article| has_category?(category, article) }
  end
  memoize :articles_with_category

  # Collect all articles and return them in sub-arrays by category.
  #
  # :call-seq:
  #   articles_by_category -> [category, array]
  #   articles_by_category(posts) -> [category, array]
  #
  # By default all articles are checked. Pass in an array to limit the
  # search to a subset of articles.
  def articles_by_category(posts=sorted_articles)
    cats = []
    all_categories.each do |cat|
      cats << [cat, articles_with_category(cat)]
    end
    cats
  end
  memoize :articles_by_category

  # Turn a collection of categories into HTML links.
  #
  # :call-seq:
  #   link_categories(cats) -> array
  #
  # This is ugly, but better here then in the middle of a layout.
  def link_categories(cats)
    cats.map do |cat|
      ['<a href="/categories/', cat, '/index.html">', cat, '</a>'].join
    end
  end

  # Create individual pages for each category under root/categories.
  #
  # There's no way to know in advance what categories the blog will have.
  # Instead of creating pages beforehand, we hook into the +preprocess+
  # method to run this method.
  #
  # The method gathers all categories and their accompanying articles,
  # creates a page for each category and lists the articles for it. Each
  # article is added to nanoc's +@items+ array for further processing.
  def create_category_pages
    articles_by_category.each do |category, posts|
      puts category.inspect
      @items << Nanoc::Item.new(
          "<%= render('category', :category => '#{category}') %>",
          {
              :title => "Posts in the #{category}",
              :h1 => "#{category} posts",
              :menu => "blog",
              :posts => posts
          },
          "/categories/#{category}",
          :binary => false
      )
    end
  end
end

include Categories