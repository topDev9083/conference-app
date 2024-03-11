export interface IImage {
    file: string;
    backgroundColor: string;
    size: Readonly<ISize>;
}

export interface ISize {
    width?: number;
    height?: number;
}

export interface IIOSConfig {
    applicationId: string;
    appstoreId: string;
    splash: Readonly<IImage>;
    appIcon: Readonly<IImage>;
    firebaseConsoleFile: string;
}

export interface IAndroidConfig {
    applicationId: string;
    splash: Readonly<IImage>;
    appIcon: Readonly<IImage>;
    firebaseConsoleFile: string;
}

export interface IConfig {
    appName: string;
    subdomain: string;
    ios: Readonly<IIOSConfig>;
    android: Readonly<IAndroidConfig>;
}
