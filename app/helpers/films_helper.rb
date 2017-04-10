module FilmsHelper
  def render_film_description(film)
    simple_format(film.description)
  end
end
