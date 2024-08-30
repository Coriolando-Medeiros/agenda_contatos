@agenda = []  # Inicialize a agenda fora dos métodos como uma variável de instância

def menu
  loop do
    puts "Agenda de contatos"
    puts ""
    puts "1 - Adicionar"
    puts "2 - Editar"
    puts "3 - Excluir"
    puts "4 - Listar"
    puts "0 - Sair"
    
    print "Opção: "
    opcao = gets.chomp

    if opcao == '1'
      puts "Adicionar novo contato"
      adicionar
    elsif opcao == '2'
      puts "Editar contato"
      editar
    elsif opcao == '3'
      puts "Excluir contato"
      excluir
    elsif opcao == '4'
      puts "Listar contatos"
      listar
    elsif opcao == '0'
      puts "Saindo..."
      return
    else
      puts "Opção inválida, Tente novamente!"
    end
  end
end

def adicionar
  print "Nome: "
  nome = gets.chomp.capitalize
  print "Telefone: "
  telefone = gets.chomp
  print "E-mail: "
  email = gets.chomp.downcase

  File.open("agenda_contatos.txt", "a") do |file|
    file.puts "Nome: #{nome}, Telefone: #{telefone}, Email: #{email}"
  end
  puts "Contato adicionado!"

  
end

def listar
  if File.exist?("agenda_contatos.txt") && !File.zero?("agenda_contatos.txt")
    File.open("agenda_contatos.txt", "r") do |file|
      file.each_line do |linha|
        puts linha
      end
    end
  else
    puts "Agenda vazia!"
    puts "Adicionar novo contato?"
    puts "1 - Sim | Enter - Não"
    opcao = gets.chomp
    if opcao == '1'
      adicionar
    else
      puts "Saindo..."
      return
    end
  end
end


def editar
  if File.exist?("agenda_contatos.txt") && !File.zero?("agenda_contatos.txt")
    File.open("agenda_contatos.txt", "r") do |file|
      file.each_line do |linha|
        puts linha
      end
    end

    puts ""
    puts "Digite o nome do contato que deseja editar"
    nome_editar = gets.chomp.capitalize

    linhas = File.readlines("agenda_contatos.txt")
    contato_encontrado = false

    linhas.map! do |linha|
      if linha.include?("Nome: #{nome_editar},")
        puts "Contato encontrado: #{linha}"
        puts "Novo nome | pressione Enter para manter"
        novo_nome = gets.chomp.capitalize
        puts "Novo Telefone | pressione ENTER para manter"
        novo_telefone = gets.chomp
        puts "Novo email | pressione ENTER para manter"
        novo_email = gets.chomp.downcase

        novo_nome = nome_editar if novo_nome.empty?
        novo_telefone = linha.match(/Telefone: (\S+)/)[1] if novo_telefone.empty?
        novo_email = linha.match(/Email: (\S+)/)[1] if novo_email.empty?

        contato_encontrado = true
        "Nome: #{novo_nome}, Telefone: #{novo_telefone}, Email: #{novo_email}\n"
      else
        linha
      end
    end

    if contato_encontrado
      File.open("agenda_contatos.txt", "w") do |file|
        file.puts(linhas)
      end
      puts "Contato atualizado com sucesso!"
    else
      puts "Contato não encontrado!"
    end
  else
    puts "Arquivo de contatos não encontrado ou está vazio!"
  end
end


def excluir
  if @agenda.empty?
    puts "Agenda vazia!"
    puts "Adicionar novo contato?"
    puts "1 - Sim | Enter - não"
    opcao = gets.chomp.to_i
    if opcao == '1'
      adicionar
    else
      puts "Saindo..."
      return
    end
  else
    @agenda.each_with_index do |contato, indice|
      puts "Contato: #{indice + 1} : Nome: #{contato[:nome]}, Tel: #{contato[:telefone]}, Email: #{contato[:email]}"
    end
    puts "Qual contato deseja excluir?"
    puts "Digite o número"
    escolha = gets.chomp.to_i - 1
    if escolha >= 0 && escolha < @agenda.size
      @agenda.delete_at(escolha)
      puts "Contato excluido!"
    else
      puts "Escolha inválida!"
    end
  end
end
menu

