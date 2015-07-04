class Robot
  attr_accessor :position, :items, :health, :equipped_weapon
  def initialize
    @position = [0, 0]
    @items = []
    @health = 100
  end

  def items_weight
    if items.empty?
      0
    else
      items.inject(0) {|accu, item| accu + item.weight}
    end
  end

  def pick_up(item)
    if self.items_weight + item.weight <= 250
      self.items << item
    else
      raise ArgumentError
    end
  end

  def move_left
    self.position[0] -= 1
  end

  def move_right
    self.position[0] += 1
  end

  def move_up
    self.position[1] += 1
  end

  def move_down
    self.position[1] -= 1
  end

  def wound(dmg)
    health - dmg < 0 ? self.health = 0 : self.health -= dmg
  end

  def heal(hpup)
    health + hpup > 100 ? self.health = 100 : self.health += hpup
  end

  def attack(beep_boop_two)
    if equipped_weapon.nil?
      beep_boop_two.wound(5)
    else
      equipped_weapon.hit(beep_boop_two)
    end
  end
end

class Item
  attr_reader :name, :weight

  def initialize(name, weight)
    @name = name
    @weight = weight
  end
end

class Bolts < Item
  def initialize
    super("bolts", 25)
  end

  def feed(beep_boop)
    beep_boop.heal(25)
  end
end

class Weapon < Item
  attr_reader :damage

  def initialize(name, weight, damage)
    super(name, weight)
    @damage = damage
  end

  def hit(beep_boop)
    beep_boop.wound(damage)
  end
end

class Laser < Weapon
  def initialize
    super("laser", 125, 25)
  end
end

class PlasmaCannon < Weapon
  def initialize
    super("plasma_cannon", 200, 55)
  end
end
