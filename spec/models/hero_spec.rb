require 'spec_helper'

describe Hero do

  subject(:hero) { build(:hero) }
  
  it "has a valid factory" do
    expect(hero).to be_valid
  end

  it "requires a title" do
    expect(build(:hero, title: '')).to_not be_valid
  end

  it "requires a subtitle" do
    expect(build(:hero, subtitle: nil)).to_not be_valid
  end

  it "uses title and sub as nav title and nav subtitle if none given" do
    expect(create(:hero, navtitle: nil).navtitle).to eq(hero.title)
    expect(create(:hero, navsubtitle: nil).navsubtitle).to eq(hero.subtitle)
  end

  it "expects a non-nil 'active' value" do
    expect(build(:hero, active: nil)).to_not be_valid
  end

  it "requires an image attachment" do
    expect(build(:hero, image_file_name: nil)).to_not be_valid
    expect(build(:hero, image_content_type: 'text/html')).to_not be_valid
  end

  specify "#active? returns active state" do
    expect(hero.active?).to eq(hero.active)
  end

  specify "#to_s returns the title" do
    expect("#{hero}").to eq(hero.title)
  end

  it "requires content" do
    expect(build(:hero, content: nil)).to_not be_valid
  end

  it "defaults to an HTML markup content type" do
    expect(create(:hero, content_markup_type: nil).content_markup_type).to eq('html')
  end

  specify "#_content_rendered is just #content" do
    expect(create(:hero)._content_rendered).to eq(hero.content)
  end

  describe "scopes" do
    it "returns active" do
      hero_1 = create(:hero, order: 1, active: true)
      hero_2 = create(:hero, order: 2, active: false)
      hero_3 = create(:hero, order: 3, active: true)
      expect(Hero.active).to eq([hero_1, hero_3])
    end

    it "returns in order" do
      hero_1 = create(:hero, order: 1, active: true)
      hero_2 = create(:hero, order: 2, active: false)
      hero_3 = create(:hero, order: 3, active: true)
      expect(Hero.all).to eq([hero_1, hero_2, hero_3])
    end

    it "returns a random Hero" do
      hero_1 = create(:hero, active: true)
      hero_2 = create(:hero, active: true)
      expect([Hero.random].count).to eq(1)
    end

    it "does not have an institution scope" do
      expect{Hero.institution()}.to raise_error
    end
  end

end
