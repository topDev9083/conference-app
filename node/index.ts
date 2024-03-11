import * as airesize from 'airesize';
import * as Logger from './utils/logger';
import {hideBin} from 'yargs/helpers';
import * as yargs from 'yargs';
import * as _ from 'lodash';
import * as fs from 'fs';
import * as path from 'path';
import {IConfig} from './others/interfaces';
import * as IOSService from './services/ios.service';
import * as AndroidService from './services/android.service';
import * as CommonService from './services/common.service';

const run = async () => {
    airesize.enableLog();
    const argv = await yargs(hideBin(process.argv))
        .argv;
    const eventCode = _.head<any>(argv._);
    if (!eventCode) {
        throw Error('Event code is required');
    }
    const eventCodeDir = path.join('..', 'event_codes', eventCode);
    if (!fs.existsSync(eventCodeDir)) {
        throw Error('Invalid event code');
    }
    const config: IConfig = JSON.parse(fs.readFileSync(path.join(
        eventCodeDir,
        'config.json'))
        .toString());
    await CommonService.handleCommonConfig(eventCode, config);
    await AndroidService.handleAndroidConfig({
        config: config.android,
        eventCode,
    });
    await IOSService.handleIOSConfig({
        eventCode,
        appName: config.appName,
        config: config.ios,
    });
};

run().then(() => {
    Logger.success('Success');
})
    .catch((error) => {
        Logger.error(error.toString());
    });


