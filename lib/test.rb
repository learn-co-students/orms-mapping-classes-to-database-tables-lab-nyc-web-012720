require_relative '../config/environment'

k = DB[:conn].execute("SELECT * FROM Students")

pp k