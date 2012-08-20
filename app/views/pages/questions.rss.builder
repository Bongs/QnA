xml.instruct! :xml, version: "1.0" 
xml.rss version: "2.0" do
  xml.channel do
    xml.title "My Questions"
    xml.description "Question ans Answer site"
    xml.link pages_questions_url

    @questions.each do |q|
      xml.item do
        xml.title q.title
        xml.description q.body
        q.answers.each do |a|
          xml.answer a.body
        end
        xml.pubDate q.created_at.to_s(:rfc822)
        xml.link pages_questions_url(q)
        xml.guid pages_questions_url(q)
      end
    end
  end
end
