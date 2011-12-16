# encoding: utf-8
module R18n
  class Locales::Ca < Locale
    set :title => 'Català',

        :wday_names => %w{diumenge dilluns dimarts dimecres dijous divendres
                          dissabte},
        :wday_abbrs => %w{dg dl dm dc dj dv ds},

        :month_names => %w{Gener Febrer Març Abril Maig Juny Juliol Agost
                           Setembre Octubre Novembre Desembre},
        :month_abbrs => %w{gen feb mar abr mai jun jul ago set oct nov des},

        :date_format => '%d/%m/%Y',
        :full_format => '%d de %B',
        :year_format => '_ de %Y',

        :number_decimal => ",",
        :number_group   => "."
  end
end
