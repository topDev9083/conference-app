import * as _ from 'lodash';

export const parseXCConfig = (xcConfig: string): {
    [key: string]: string,
} => {
    const lines = xcConfig.split('\n')
        .map((line) => line.trim())
        .filter((line) => line)
        .filter((line) => line.split('=').length === 2);
    const obj = {} as any;
    for (const line of lines) {
        const sLine = line.split('=').map((kv) => kv.trim());
        obj[sLine[0]] = sLine[1];
    }
    return obj;
};

export const generateXCConfig = (obj: Readonly<{ [key: string]: string }>)
    : string => {
    const lines: string[] = [];
    _.keys(obj).forEach((key) => {
        lines.push(`${key}=${obj[key]}`);
    });
    return lines.join('\n');
};
