import {IConfig} from '../others/interfaces';
import * as fs from 'fs';
import * as path from 'path';
import {generateXCConfig, parseXCConfig} from '../utils/xc-config-parser';

export const handleCommonConfig =
    (eventCode: string, config: Readonly<IConfig>): void => {
        [
            'localhost',
            'stage',
            'production',
        ].forEach((env) => {
            const xcConfigPath = path.join('..', 'config', `${env}.config`);
            const sXCConfig = fs.readFileSync(xcConfigPath).toString();
            const xcConfig = parseXCConfig(sXCConfig);
            xcConfig['APP_NAME'] = config.appName;
            switch (env) {
                case 'stage':
                    xcConfig['DEEP_LINK'] = `${config.subdomain}.eventmeet.xyz`;
                    break;
                case 'production':
                    xcConfig['DEEP_LINK'] = `${config.subdomain}.eventmeet.io`;
                    break;
            }
            xcConfig['EVENT_CODE'] = eventCode;
            const newSXCConfig = generateXCConfig(xcConfig);
            fs.writeFileSync(xcConfigPath, newSXCConfig);
        });
    };
