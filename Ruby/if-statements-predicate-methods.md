# Should I Use if Statements? (Or AI Features to the Rescue)

```ruby
class AnimalClassifier
  attr_accessor :entity, :knowledge_base

  def initialize(entity, knowledge_base)
    @entity = entity
    @knowledge_base = knowledge_base
  end

  def make_observations
    observations = {}
    @knowledge_base.keys.each do |key|
      @knowledge_base[key].each do |fact|
        observations[key] ||= []
        observations[key].push({ fact.to_sym => send("#{fact}?") })
      end
    end
    observations
  end

  def quadruped?
    return true if @entity =~ /4|four leg/
    false
  end

  def walks?
    return false if @entity =~ /not walk/
    return true if @entity =~ /walk/
    false
  end

  def gallops?
    return true if @entity =~ /gallop/
    false
  end

  def neighs?
    return true if @entity =~ /neigh/
    false
  end

  def biped?
    return true if @entity =~ /biped/
    false
  end

  def runs?
    return true if @entity =~ /run/
    false
  end

  def speaks_english?
    return true if @entity =~ /speak|english/
    false
  end

  def swims?
    return true if @entity =~ /swim|not walk|can't walk/
    false
  end

  def breathes_water?
    return true if @entity =~ /breathe|water/
    false
  end

  def gills?
    return true if @entity =~ /gills/
    false
  end
end

animal_clues = [
  'What has 4 legs, can gallop, and neighs?',
  'What has 2 legs, can walk and run, and speaks english?',
  'What has gills, does not walk, but swims?',
]

knowledge_base = {
  horse: [:quadruped, :walks, :gallops, :neighs],
  human: [:biped, :walks, :runs, :speaks_english],
  fish: [:swims, :breathes_water, :gills],
}

classifier = AnimalClassifier.new(animal_clues[2], knowledge_base)
puts classifier.make_observations
```
