import { api, LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import insertFile from '@salesforce/apex/fileUploadInsert.insertFile';

export default class CustomFilesUpload extends LightningElement {
    @api recordId;
    fileData;
    hasFiles = false;

    handleFileChange(event) {
        const file = event.target.files[0];
        var reader = new FileReader();
        console.log('Record Id : ' + this.recordId);
        reader.onload = () => {
            var base64 = reader.result.split(',')[1];
            this.fileData = {
                'recordId' : this.recordId,
                'base64Data' : base64,
                'filename' : file.name
            }
            console.log('File Data : '+JSON.stringify(this.fileData));
            this.hasFiles = true;
        }
        reader.readAsDataURL(file);
    }

    handleSubmit() {
        const {recordId, base64Data, filename} = this.fileData;
        insertFile({recordId, base64Data, filename})
        .then(result => {
            this.fileData = null;
            this.hasFiles = false;
            this.toast('Success', 'File uploaded successfully', 'success');
        })
        .catch(error => {
            console.log('Error : '+ error.body.message);
            this.toast('Error', error.body.message, 'error');
        });
    }

    toast(title, message, type) {
        const event = new ShowToastEvent({
            title,
            message,
            variant: type
        });
        this.dispatchEvent(event);
    }
}