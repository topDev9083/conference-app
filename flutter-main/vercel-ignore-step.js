const commitMessage = process.env['VERCEL_GIT_COMMIT_MESSAGE'] ?? '';
const branch = process.env['VERCEL_GIT_COMMIT_REF'];
const isProduction = process.argv.indexOf('production') >= 0;
const isStage = process.argv.indexOf('stage') >= 0;

const cancelBuild = () => {
    console.log('🛑 - Build cancelled');
    process.exit(0);
};

if (commitMessage.indexOf(['[SKIP_CI]']) >= 0) {
    cancelBuild();
}

if(isProduction && branch !== 'master') {
    cancelBuild();
}

if(isStage && branch !== 'stage') {
    cancelBuild();
}

console.log('✅ - Build can proceed');
process.exit(1);


