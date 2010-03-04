require 'rubygems'
require 'active_support'
require 'active_support/core_ext'
require 'happymapper'
require 'pp'

class Article
  include HappyMapper
  
  element :id_article, Integer
  element :surtitre, String
  element :titre, String
  element :soustitre, String
  element :id_rubrique, Integer
  element :descriptif, String
  element :chapo, String
  element :texte, String
  element :ps, String
  element :date, DateTime
  element :statut, String
  element :id_secteur, Integer
  element :maj, DateTime
  element :export, String
  element :date_redac, DateTime
  element :visites, Integer
  element :referers, Integer
  element :popularite, Float
  element :accepter_forum, String
  element :date_modif, DateTime
  element :extra, String
  element :lang, String
  element :langue_choisie, String
  element :id_trad, Integer
  element :nom_site, String
  element :url_site, String
  element :id_version, Integer
  element :idx, String
  element :url_propre, String
end

categories = {
  1 => 'reunions',
  2 => 'animations',
  3 => 'association',
  5 => 'divers',
  4 => 'divers',
  7 => 'divers',
  8 => 'divers',
  9 => 'emploi',
  12 => 'divers',
}

def transform_spip(text)
  text.gsub!(/<\/?html>/, '')
  text.gsub!(/<\/?ul>/, '')
  text.gsub!(/<\/?h3>/, '')
  text.gsub!(/<br \/>/, '')
  text.gsub!(/ class="spip"/, '')
  
  text.gsub!(/<h3>La Bo\[a\]te<br \/>/, "> La Bo\[a\]te")
  text.gsub!(/35 rue de la Paix Marcel Paul<br \/>/, "> 35 rue de la Paix Marcel Paul")
  text.gsub!(/13001 Marseille<br \/><\/h3>/, "> 13001 Marseille")
  
  text.gsub!(/^- \{\{([^\}]+)\}\}(\s-+)?/,'### \1 ###')
  text.gsub!(/\{\{\{([^\}]+)\}\}\}/,'### \1 ###')
  text.gsub!(/\*\*([^\*]+)\*\*(\s-+)?/,'### \1 ###')
  text.gsub!(/\{\{([^\}]+)\}\}(\s-+)?/,'**\1**')
  text.gsub!(/\{([^\}]+)\}/,'*\1*')
  text.gsub!(/\n_ ?/, "  \n")
  text.gsub!(/^•/, "* ")
  text.gsub!(/<\/?i>/,'*')
  text.gsub!(/<\/?b>/,'**')
  text.gsub!(/Ã»/,'û')
  
  text.gsub!(/\[[^\]]+\]/) do |c|
    a, b = c[1..-2].split('->')
    '[' + (a.present? ? a : b).to_s + '](' + b.to_s + ')'
  end
  
  text.gsub!(/&/, '&amp;')
  text.gsub!(/La Bo\[a\]\(\)te/, "La Bo\[a\]te")
  
  text.gsub!(/\(rub1\)/, '(/archives-categories.html#reunions)')
  text.gsub!(/\(art2\)/, '(/association/les-reunions-du-plug/)')
  text
end

xml = File.read('/Users/jlecour/Desktop/spip_articles.xml')

Article.parse(xml).each do |article|
  if article.statut == 'publie'
    lines = []
    lines << "---"
    lines << "title: \"" + transform_spip(article.titre).gsub(/"/,'\"') + "\""
    lines << "layout: post"
    lines << "subtitle: " + transform_spip(article.soustitre) if article.soustitre.present?
    lines << "categories: " + categories[article.id_rubrique]
    lines << "spip_id: " + article.id_article.to_s
    lines << "---"
    if article.chapo.present?
      lines << %Q{<p class="chapo">\n#{transform_spip(article.chapo)}\n</p>\n}
    end
    if article.texte.present?
      lines << transform_spip(article.texte)
    end
    if article.ps.present?
      lines << %Q{\n\n----\n#{transform_spip(article.ps)}}
    end
    
    slug = article.titre.parameterize
    file_name = article.date.strftime('%Y-%m-%d') + '-' + slug + '.markdown'
    file_path = "/Users/jlecour/Sites/jekyll_plugfr/_posts/#{file_name}"
    File.open(file_path, 'w') do |f|
      f.write(lines.join("\n"))
    end
  end
end