from PIL import Image, ImageDraw, ImageFont

# Carregar a foto do perfil
profile_photo = Image.open('/home/kelsey/Imagens/kelseysantos.png')  # Caminho para sua foto
profile_photo = profile_photo.resize((100, 100))  # Redimensiona para tamanho pequeno

# Criar a imagem de contato
width, height = 450, 150
contact_image = Image.new('RGB', (width, height), (255, 255, 255))  # Fundo branco
draw = ImageDraw.Draw(contact_image)

# Inserir a foto ao lado esquerdo
contact_image.paste(profile_photo, (10, 25))  # Coloca a foto em (10, 25)

# Carregar uma fonte para o texto (opcional)
font = ImageFont.truetype("arial.ttf", size=20)  # Especificar fonte ou usar default

# Escrever o nome
draw.text((120, 30), "Kelsey Santos", fill=(0, 0, 0), font=font)

# Escrever o telefone e email
draw.text((120, 60), "Telefone: (65)98409-4803", fill=(0, 0, 0), font=font)
draw.text((120, 90), "Email: kelseysantos@yahoo.com.br", fill=(0, 0, 0), font=font)

# Salvar a imagem final
contact_image.save('kelseysantoscontato.png')