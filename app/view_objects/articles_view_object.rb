# View object for Articles
class ArticlesViewObject
  attr_reader :article

  def initialize(article)
    @article = article
  end
end
