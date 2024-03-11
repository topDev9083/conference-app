import {IAndroidConfig} from '../others/interfaces';
import * as path from 'path';
import * as airesize from 'airesize';
import {generateXCConfig, parseXCConfig} from '../utils/xc-config-parser';
import * as fs from 'fs';
import * as xmlbuilder from 'xmlbuilder';

export const handleAndroidConfig = async (input: Readonly<{
    config: Readonly<IAndroidConfig>,
    eventCode: string,
}>) => {
    const resDir = path.join(
        '..',
        'android',
        'app',
        'src',
        'main',
        'res'
    );
    const appIconPath = path.join(
        '..',
        'event_codes',
        input.eventCode,
        input.config.appIcon.file
    );

    /* -- app icon -- */
    await airesize.generateAndroidAppIcons({
        input: {
            foregroundIconPath: appIconPath,
            backgroundIconColor: input.config.appIcon.backgroundColor,
        },
        output: {
            dir: resDir,
            colorFileName: 'app_icon_colors',
            foregroundIconName: 'ic_app_icon_fg',
            backgroundIconOrColorName: 'app_icon_colors',
            mainIconName: 'ic_app_icon_round',
        },
    });

    /* -- notification icon -- */
    await airesize.generateAndroidNotificationIcons({
        input: {
            imagePath: appIconPath,
        },
        output: {
            dir: resDir,
            imageName: 'ic_notification',
        },
    });

    /* -- splash -- */
    await airesize.generateAndroidImages({
        input: {
            imagePath: path.join(
                '..',
                'event_codes',
                input.eventCode,
                input.config.splash.file
            ),
        },
        output: {
            width: input.config.splash.size.width || airesize.InputSize.auto,
            height: input.config.splash.size.height || airesize.InputSize.auto,
            dir: resDir,
            imageName: 'splash_logo',
        },
    });
    const splashColorsXml = xmlbuilder.create('resources', {
        encoding: 'utf-8',
    }).ele('color', {
        'name': 'splash_bg',
    }, `#${input.config.splash.backgroundColor}`);
    fs.writeFileSync(path.join(resDir, 'values', 'splash_colors.xml'),
        splashColorsXml
            .end({
                pretty: true,
            }));


    /* -- application id -- */
    const commonPropertiesPath = path.join(
        '..',
        'android',
        'common.properties'
    );
    const commonProperties = parseXCConfig(fs.readFileSync(commonPropertiesPath)
        .toString());
    commonProperties['APPLICATION_ID'] = input.config.applicationId;
    fs.writeFileSync(commonPropertiesPath, generateXCConfig(commonProperties));

    /* -- firebase console file -- */
    fs.copyFileSync(
        path.join(
            '..',
            'event_codes',
            input.eventCode,
            input.config.firebaseConsoleFile),
        path.join(
            '..',
            'android',
            'app',
            'google-services.json')
    );
};
