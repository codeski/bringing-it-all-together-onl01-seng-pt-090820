class Dog
  
  attr_accessor :id, :name, :breed
  
  def initialize(hash)
    @name = hash[:name]
    @breed = hash[:breed]
  end
  
  def self.create_table
    sql = "CREATE TABLE IF NOT EXISTS dogs (id INTEGER PRIMARY KEY, name TEXT, breed TEXT)"
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = "DROP TABLE IF EXISTS dogs"
    DB[:conn].execute(sql)
  end
  
  def save
    if self.id
      self.update
    else
      sql = "INSERT INTO dogs (name, breed) VALUES (?, ?)"
      DB[:conn].execute(sql, self.name, self.breed)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
      DB[:conn].execute("SELECT * FROM dogs WHERE id = @id").map do |row|
        hash = {}
        binding.pry
      end
    # binding.pry
    end
  end
  
  def self.new_from_db
  end
  
  def update
    sql = "UPDATE dogs SET name = ?, breed = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.breed, self.id)
  end
  
end