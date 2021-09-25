import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { onError, subscribe, unsubscribe } from "lightning/empApi";
import search from '@salesforce/apex/LogController.search';

import userId from "@salesforce/user/Id";
import locale from "@salesforce/i18n/locale";

const TYPE = { STREAM: "STREAM", MANUAL: "MANUAL" };
export default class LogMonitor extends LightningElement {
	subscription;
	isMuted = false;
	logs = {};
	type = TYPE.STREAM;
	fromDate;
	toDate;

	logsAsTree = [];

	get columns() {
		if (this.type === TYPE.MANUAL) {
			return [
				{
					type: "date",
					fieldName: "CreatedDate",
					label: "Date",
					initialWidth: 200,
				},
				{
					type: "text",
					fieldName: "Class__c",
					label: "Class",
					initialWidth: 200
				},
				{
					type: "text",
					fieldName: "Method__c",
					label: "Method"
				},
				{
					type: "text",
					fieldName: "Message__c",
					label: "Message",
				},
			]
		} else {
			return [
				{
					type: "number",
					fieldName: "index",
					label: "#",
					initialWidth: 10
				},
				{
					type: "text",
					fieldName: "context",
					label: "Context",
					initialWidth: 100
				},
				{
					type: "text",
					fieldName: "time",
					label: "Time",
					initialWidth: 100
				},
				{
					type: "text",
					fieldName: "Class__c",
					label: "Class",
					initialWidth: 200
				},
				{
					type: "text",
					fieldName: "Line__c",
					label: "Line",
					initialWidth: 200
				},
				{
					type: "text",
					fieldName: "Method__c",
					label: "Method"
				},
				{
					type: "text",
					fieldName: "Level__c",
					label: "Level",
				},
				{
					type: "text",
					fieldName: "Message__c",
					label: "Message",
				},
			]
		}
	}

	connectedCallback() {
		this.subscribe();
	}

	async changeType(event) {
		this.logsAsTree = [];
		if (event.currentTarget.checked) {
			this.type = TYPE.STREAM;
			await this.subscribe();
		} else {
			this.type = TYPE.MANUAL;
			this.unsubscribe();
		}
	}

	onInputChange(event) {
		const { name, value } = event.currentTarget;
		this[name] = value;
	}

	disconnectedCallback() {
		this.unsubscribe();
	}

	clearAll() {
		this.logs = {};
		this.logsAsTree = [];
	}

	async subscribe() {
		if (!this.subscription) {
			unsubscribe();
		}
		this.subscription = await subscribe("/event/Log__e", -1, (message) => this.receive(message));

		onError(error => {
			console.error(JSON.stringify(error));
		});
	}

	unsubscribe() {
		unsubscribe(this.subscription, response => {});
		this.subscription = null;
	}

	receive(message) {
		const log = message.data.payload;
		if (log.User__c === userId) {
			const timeFormat = { hour: 'numeric', minute: 'numeric', second: 'numeric' };
			log.time = new Intl.DateTimeFormat(locale, timeFormat).format(new Date(log.CreatedDate));

			const context = log.Context__c;
			this.logs[context] = this.logs[context] || [];
			this.logs[context].push(log);

			this.renderTree();
		}
	}

	renderTree() {
		let index = 1;
		this.logsAsTree = [];

		for (const context in this.logs) {
			let log = this.logs[context][0];
			log.index = index;
			log.context = context.split("/")[1];

			if (this.logs[context].length > 1) {
				log._children = this.logs[context].slice(1);
			}

			this.logsAsTree.push(log);
			index++;
		}

		this.template
			.querySelector("lightning-tree-grid")
			.expandAll();
	}

	toggleMute() {
		this.isMuted = !this.isMuted;

		if (this.isMuted) {
			this.unsubscribe();
		} else {
			this.subscribe();
		}
	}

	async doSearch() {
		if (!this.fromDate || !this.toDate) {
			return;
		}
		this.logsAsTree = await search({ fromDate: this.fromDate, toDate: this.toDate });
	}

	get muteIcon() {
		return (this.isMuted) ? "utility:volume_off" : "utility:volume_high";
	}

	get muteLabel() {
		return (this.isMuted) ? "Unmute" : "Mute";
	}

	get isStream() {
		return this.type === TYPE.STREAM;
	}

	get disableSearch() {
		return !this.fromDate || !this.toDate;
	}
}
