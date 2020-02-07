class Student

	attr_accessor :name, :grade, :id

  def initialize(name, grade, id = nil)
		@name = name
		@grade = grade
		@id = id
		self.save
  end

  def self.create_table
    sql =  <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade TEXT
        )
        SQL
    DB[:conn].execute(sql) 
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, album) 
      VALUES (?, ?)
    SQL
 
    DB[:conn].execute(sql, self.name, self.album)
 
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def next_id()
  	database_id = DB[:conn].execute("SELECT MAX(id) from students")
  	database_id ? database_id + 1 : 1
  end



end