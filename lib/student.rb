class Student

	attr_accessor :name, :grade
	attr_reader :id

  def initialize(name, grade, id=1)
    @id = id
    @name = name
    @grade = grade
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

  def self.drop_table
  	    sql =  <<-SQL 
      DROP TABLE students
        SQL

  	DB[:conn].execute(sql)

  end

  def save
sql = <<-SQL
      INSERT INTO students (name, grade, id) 
      VALUES (?, ?, ?)
    SQL
 
    DB[:conn].execute(sql, self.name, self.grade, self.id)
 
  end

  def next_id()
  	database_id = DB[:conn].execute("SELECT MAX(id) from students")
  	database_id ? database_id + 1 : 1
  end

  def self.create(hash)
    result = Student.new(hash[:name], hash[:grade])
    result.save
    return result
  end




end