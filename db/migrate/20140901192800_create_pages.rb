class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.integer :institution_id
      t.integer :sort_order
      t.string  :topic_id
      t.string  :slug
    end

    pages = [
      { id: 1,   institution_id: 1,  sort_order: 1,   topic_id: "about",      slug: "what-is-the-data-common"       },
      { id: 2,   institution_id: 1,  sort_order: 2,   topic_id: "about",      slug: "frequently-asked-questions"    },
      { id: 3,   institution_id: 1,  sort_order: 3,   topic_id: "about",      slug: "tools"                         },
      { id: 4,   institution_id: 1,  sort_order: 4,   topic_id: "about",      slug: "partners"                      },
      { id: 5,   institution_id: 1,  sort_order: 5,   topic_id: "about",      slug: "contact"                       },
      { id: 6,   institution_id: 1,  sort_order: 6,   topic_id: 'resources',  slug: "training-guides-and-tutorials" },
      { id: 7,   institution_id: 1,  sort_order: 7,   topic_id: 'resources',  slug: "data-resources"                },
      { id: 8,   institution_id: 1,  sort_order: 8,   topic_id: 'resources',  slug: "user-profiles"                 },
      { id: 9,   institution_id: 1,  sort_order: 9,   topic_id: 'community',  slug: "data-day-2009"                 },
      { id: 10,  institution_id: 1,  sort_order: 10,  topic_id: 'community',  slug: "data-day-2012"                 },
      { id: 11,  institution_id: 1,  sort_order: 11,  topic_id: 'community',  slug: "data-day-2013"                 },
      { id: 12,  institution_id: 2,  sort_order: 1,   topic_id: "about",      slug: "what-is-the-data-common"       },
      { id: 13,  institution_id: 2,  sort_order: 2,   topic_id: "about",      slug: "frequently-asked-questions"    },
      { id: 14,  institution_id: 2,  sort_order: 3,   topic_id: "about",      slug: "tools"                         },
      { id: 15,  institution_id: 2,  sort_order: 4,   topic_id: "about",      slug: "partners"                      },
      { id: 16,  institution_id: 2,  sort_order: 5,   topic_id: "about",      slug: "contact"                       },
      { id: 17,  institution_id: 2,  sort_order: 6,   topic_id: 'resources',  slug: "training-guides-and-tutorials" },
      { id: 18,  institution_id: 2,  sort_order: 7,   topic_id: 'resources',  slug: "data-resources"                },
      { id: 19,  institution_id: 2,  sort_order: 8,   topic_id: 'resources',  slug: "user-profiles"                 },
      { id: 20,  institution_id: 2,  sort_order: 9,   topic_id: 'community',  slug: "data-day-2009"                 },
      { id: 21,  institution_id: 2,  sort_order: 10,  topic_id: 'community',  slug: "data-day-2012"                 },
      { id: 22,  institution_id: 2,  sort_order: 11,  topic_id: 'community',  slug: "data-day-2013"                 }
    ]
    pages.each {|page| Page.create_or_update page }

  end

  def down
    drop_table :pages
  end
end
