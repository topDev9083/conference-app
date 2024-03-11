export class ColorUtils {
    static hexToIOSRGB(hex: string) {
        hex = `#${hex}`;
        const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
        if (!result) {
            throw Error('Invalid hex provided');
        }
        return {
            red: parseInt(result[1], 16),
            green: parseInt(result[2], 16),
            blue: parseInt(result[3], 16),
        };
    }
}
