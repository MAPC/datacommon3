[![Build Status](https://travis-ci.org/MAPC/datacommon3.svg?branch=master)](https://travis-ci.org/MAPC/datacommon3) [![Code Climate](https://codeclimate.com/github/MAPC/datacommon3/badges/gpa.svg)](https://codeclimate.com/github/MAPC/datacommon3) [![Test Coverage](https://codeclimate.com/github/MAPC/datacommon3/badges/coverage.svg)](https://codeclimate.com/github/MAPC/datacommon3)

```
foreman run rails c
RAILS_ENV=production foreman run rake assets:precompile
(RAILS_ENV=production) foreman start
```

```ruby
def name_slug_options(objects)
  options_for_select(objects.map {|g| [g.name, g.slug]})
end


def options_for_area(type, selected)
  # TODO: Don't break the Law of Demeter
  geographies = @institution.geographies
                    .where(type: params[:type])
                    .pluck(:name, :slug)
  options_for_select(geographies, selected)
end
```