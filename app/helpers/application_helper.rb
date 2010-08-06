# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper
  
  def estados_com_eventos
    eventos = Evento.find_by_sql("select distinct estado from eventos where aprovado = 1 order by estado asc")    
    @estados = []    
    eventos.each do |e|
        @estados << e.estado
    end
    @estados    
  end
  
  def twits_do_evento(evento)
    # implementacao as pressas pra aproveitar o oxenterails - refactor me , pls
    @images = []
    Twitter::Search.new(evento.twitter).page(1).per_page(88).each do |r| 
      @images << r.profile_image_url
    end
    
    @ultimos_twits = []
    Twitter::Search.new(evento.twitter).page(1).per_page(3).each do |r| 
      @ultimos_twits << r
    end    
    yield @images,@ultimos_twits    
  end  
end


