import { LightningElement, track } from 'lwc';

export default class CustomFilesUpload extends LightningElement {
    @track filesList = [];
    hasFiles = false;

    handleUpload() {
        this.template.querySelector('input[type="file"]').click();
    }

    handleFileChange(event) {
        if(event.target.files.length > 0) {
            this.filesList = Array.from(event.target.files);
            this.hasFiles = true;
        }
    }

    handleSubmit() {
        console.log('File List : ' + this.filesList);
    }
}