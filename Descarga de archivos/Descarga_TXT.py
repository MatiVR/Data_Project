from googleapiclient.discovery import build
from google.oauth2 import service_account
from io import BytesIO
from googleapiclient.http import MediaIoBaseDownload

#Agregare notas para identificar mejor el codigo

# Aqui se coloca la ruta del archivo que contiene las credenciales la cuenta de servicio creada en Google Cloud
SERVICE_ACCOUNT_FILE = 'C:/Users/MATI_/OneDrive/Escritorio/Assessment_Data_Engineer/assessment-data-engineer-985d65dd5f38.json'

# Aqui se coloca el ID de la carpeta en Google Drive que contiene los archivos TXT
FOLDER_ID = '17a0kvZD1ZfRPyMCgrNlr4vCCdqN9djCv'

# Aqui se define los scopes necesarios para la seguridad
SCOPES = ['https://www.googleapis.com/auth/drive.readonly']

# Aqui se realiza la autenticación
creds = service_account.Credentials.from_service_account_file(
    SERVICE_ACCOUNT_FILE, scopes=SCOPES)

# Aqui se construye el servicio de Google Drive API
service = build('drive', 'v3', credentials=creds)

def descargar_archivos_drive_txt(folder_id, ruta_destino):
    """Descarga todos los archivos TXT de una carpeta en Google Drive"""

    # Aqui se obtiene la lista de archivos en la carpeta
    results = service.files().list(
        q=f"'{folder_id}' in parents and mimeType = 'text/plain'",
        pageSize=100, # Aqui se ajusta el valor según la cantidad de archivos
        fields="nextPageToken, files(id, name)").execute()
    files = results.get('files', [])
# En caso de no encontrar archivos en la carpeta se muestra el siguiente mensaje
    if not files:
        print('No se encontraron archivos TXT en la carpeta.')
        return

    # Aqui se descarga cada archivo TXT que se encuentra
    for file in files:
        file_id = file.get('id')
        file_name = file.get('name')

        # Aqui se crea la solicitud de descarga
        request = service.files().get_media(fileId=file_id)
        fh = BytesIO()
        downloader = MediaIoBaseDownload(fh, request)
        done = False
        #Aqui se realiza una validacion para hacer seguimiento del progreso de la descarga
        while done is False:
            status, done = downloader.next_chunk()
            print(f'Descargando {file_name}: {int(status.progress() * 100)}%')

        # Aqui se guarda el archivo en el destino
        with open(f'{ruta_destino}/{file_name}', 'wb') as f:
            fh.seek(0)
            f.write(fh.getvalue())
        print(f'Archivo {file_name} descargado.')

        # Aqui se define la ruta destino
ruta_destino = 'C:/Users/MATI_/OneDrive/Escritorio/Assessment_Data_Engineer/Descargas_Drive'
descargar_archivos_drive_txt(FOLDER_ID, ruta_destino)


