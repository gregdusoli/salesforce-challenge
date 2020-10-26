import { LightningElement, api } from "lwc";
import ACCOUNT_NUMBER_FIELD from "@salesforce/schema/Account.AccountNumber";
import TYPE_FIELD from "@salesforce/schema/Account.Type";
import NAME_FIELD from "@salesforce/schema/Account.Name";

export default class EverisChallenge extends LightningElement {
  type;
  name;
  account_number;
  fields = [TYPE_FIELD, NAME_FIELD, ACCOUNT_NUMBER_FIELD];

  @api recordId;
  @api objectApiName;

  handleSubmit(event) {
    event.preventDefault();

    const fields = event.detail.fields;

    this.template.querySelector("lightning-record-form").submit(fields);
  }

  handleReset() {
    const inputFields = this.template.querySelectorAll("lightning-input-field");

    if (inputFields) {
      inputFields.forEach((field) => {
        field.reset();
      });
    }
  }
}
