function fn() {
    var env = karate.env || 'dev';

    var config = {
        env: env,
        petstoreUrl: 'https://petstore.swagger.io/v2',
        apiKey: 'special-api',
        getRandomValue: function() {
            return Math.floor(1000 * Math.random());
        }
    };

    return config;
}
