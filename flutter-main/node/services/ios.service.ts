import {IIOSConfig} from '../others/interfaces';
import * as airesize from 'airesize';
import * as path from 'path';
import * as fs from 'fs';
import {generateXCConfig, parseXCConfig} from '../utils/xc-config-parser';
import * as _ from 'lodash';
import {splashBgContents} from '../constants/splash-bg-contents';
import {ColorUtils} from '../utils/colors';

export const handleIOSConfig = async (input: Readonly<{
    eventCode: string,
    appName: string,
    config: Readonly<IIOSConfig>,
}>): Promise<void> => {
    /* -- app icon -- */
    const assetsXcassetsDir = path.join(
        '..',
        'ios',
        'Runner',
        'Assets.xcassets'
    );
    const appIconOutputDir = path.join(assetsXcassetsDir, 'AppIcon.appiconset');
    fs.rmSync(appIconOutputDir, {
        recursive: true,
        force: true,
    });
    await airesize.generateIOSAppIcons({
        input: {
            iconPath: path.join(
                '..',
                'event_codes',
                input.eventCode,
                'app_icon.png'
            ),
            iconColor: input.config.appIcon.backgroundColor,
        },
        output: {
            dir: appIconOutputDir,
            iconName: 'Icon-App',
        },
    });

    /* -- splash -- */
    const splashFgOutputDir =
        path.join(assetsXcassetsDir, 'SplashLogo.imageset');
    fs.rmSync(splashFgOutputDir, {
        recursive: true,
        force: true,
    });
    await airesize.generateIOSImages({
        input: {
            imagePath: path.join(
                '..',
                'event_codes',
                input.eventCode,
                'splash_logo.png'
            ),
        },
        output: {
            width: input.config.splash.size.width || airesize.InputSize.auto,
            height: input.config.splash.size.height || airesize.InputSize.auto,
            dir: splashFgOutputDir,
            imageName: 'SplashLogo',
        },
    });
    const splashBgOutputDir = path.join(assetsXcassetsDir, 'SplashBG.colorset');
    const newSplashBgContents = _.cloneDeep(splashBgContents);
    const rgbColor =
        ColorUtils.hexToIOSRGB(input.config.splash.backgroundColor);
    newSplashBgContents.colors.forEach((color) => {
        const comps = color.color.components;
        comps.red = `${rgbColor.red}`;
        comps.green = `${rgbColor.green}`;
        comps.blue = `${rgbColor.blue}`;
    });
    fs.writeFileSync(path.join(splashBgOutputDir, 'Contents.json'),
        JSON.stringify(newSplashBgContents));

    /* -- application id -- */
    const commonXCConfigPath = path.join(
        '..',
        'ios',
        'Flutter',
        'Common.xcconfig'
    );
    const commonXCConfig = parseXCConfig(fs.readFileSync(commonXCConfigPath)
        .toString());
    commonXCConfig['APPLICATION_ID'] = input.config.applicationId;
    commonXCConfig['APPLE_STORE_ID'] = input.config.appstoreId;
    fs.writeFileSync(commonXCConfigPath, generateXCConfig(commonXCConfig));

    /* -- firebaseConsoleFile -- */
    fs.copyFileSync(
        path.join(
            '..',
            'event_codes',
            input.eventCode,
            input.config.firebaseConsoleFile),
        path.join(
            '..',
            'ios',
            'Runner',
            'GoogleService-Info.plist'
        )
    );
};
