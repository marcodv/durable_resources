const https = require('https');

var body = [];

function httpsRequest(options) {
    return new Promise((resolve, reject) => {
        const req = https.request(options, (res) => {
            if (res.statusCode < 200 || res.statusCode >= 300) {
                const new_req = https.get(res.headers.location, (new_res) => {
                    if (new_res.statusCode == 200) {
                        new_res.on('data', function (chunk) {
                            body.push(chunk);
                        });
                        resolve(body);
                    } else {
                        reject('Status code from new_res: ' + new_res.statusCode);
                    }
                });
            }
            res.on('end', function () {
                try {
                    body = JSON.parse(Buffer.concat(body).toString());
                } catch (e) {
                    reject(e);
                }
                resolve(body);
            });
        });
        req.on('error', (e) => {
            reject(e.message);
        });
        // send the request
        req.end();
    });
}

function postToSlack(slackWebHook, messageBody) {
    try {
        messageBody = JSON.stringify(messageBody);
    } catch (e) {
        throw new Error('Failed to stringify messageBody', e);
    }

    // Promisify the https.request
    return new Promise((resolve, reject) => {
        // general request options, we defined that it's a POST request and content is JSON
        const requestOptions = {
            method: 'POST',
            header: {
                'Content-Type': 'application/json'
            }
        };
        // actual request
        const req = https.request(slackWebHook, requestOptions, (res) => {
            let response = '';
            res.on('data', (d) => {
                response += d;
            });

            // response finished, resolve the promise with data
            res.on('end', () => {
                resolve(response);
            })
        });

        // there was an error, reject the promise
        req.on('error', (e) => {
            reject(e);
        });

        // send our message body (was parsed to JSON beforehand)
        req.write(messageBody);
        req.end();
    });

}


// Lambda starts executing here
exports.handler = async (event, context, callback) => {
    // options for App Script
    var options = {
        hostname: 'script.google.com',
        path: '/macros/s/AKfycbxC4UMoiFym-jdqqQD-3qOinP5IflFX96sca5C15ltLaAxAh9DmEN20kcsAGblWhKCE6w/exec?name=test',
        method: 'GET',
        port: 443,
        followAllRedirects: true,
        headers: {
            'Content-Length': 0, // length of the specified `body`
            'Content-Type': 'application/json',
        },
    };

        var returnLambdaMessage = JSON.stringify({
            message: 'Backup done for test'
        });

        const messageBody = {
            "username": "Backup test",
            "text": "Backup for test finished",
            "icon_emoji": ":sunglasses:"
        };
        
        const messageBodyError = {
            "username": "Backup test",
            "text": "Backup for test finished with issues",
            "icon_emoji": ":x:"
        };

        const slackWebHook = 'https://hooks.slack.com/services/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' ;

        try {
            // make call to App Script
            await httpsRequest(options);
            // The console.log below will not run until the GET request above finishes
            console.log('Backup test completed successfully! ');
            // send notification to Slack
            console.log('Sending slack message');
            const slackResponse = await postToSlack(slackWebHook, messageBody);
            console.log('Slack Message response', slackResponse);
            return callback(null, JSON.stringify(returnLambdaMessage));

        } catch (e) {
            console.error('There was a error with the request', e);
            console.error('GET request failed, error:', e.message);
            const slackResponse = await postToSlack(slackWebHook, messageBodyError);
            console.log('Slack Message response', slackResponse);
            return callback(null, JSON.stringify(returnLambdaMessage));
        }
    }