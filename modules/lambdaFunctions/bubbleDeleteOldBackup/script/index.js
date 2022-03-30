const https = require('https');

var body = [];
var returnLambdaMessage = ''
var tmpMessage = ''

function httpsRequest(options) {
    return new Promise((resolve, reject) => {
        const req = https.request(options, (res) => {
            res.setEncoding('utf8') 
            if (res.statusCode < 200 || res.statusCode >= 300) {
                const new_req = https.get(res.headers.location, (new_res) => {
                    if (new_res.statusCode == 200) {
                        new_res.on('data', function (chunk) {
                            body.push(chunk);
                            tmpMessage = Buffer.concat(body).toString('utf8')
                        }).on('end', function () {
                            tmpMessage = Buffer.concat(body).toString('utf8');
                            resolve(body);
                            console.log("Printing tmpMessage : " + tmpMessage)
                        });;
                        resolve(body);
                    } else {
                        reject('Status code from new_res: ' + new_res.statusCode);
                    }
                });
            }
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
        path: '/macros/s/AKfycbyZZaT2Y_L5fIxi9UrmMYRjvIuMQofGI1kcGvn8C7we3Nx-rW2-VwzJKQkl6B3NJ95tlA/exec?name=rotate',
        method: 'GET',
        port: 443,
        followAllRedirects: true,
        headers: {
            'Content-Length': 0, // length of the specified `body`
            'Content-Type': 'application/json',
        },
    };
        returnLambdaMessage = JSON.stringify({
            message: tmpMessage
        });
       
        const messageBodyError = {
            "username": "Deleted Backup",
            "text": "Deleted old Backups for production and UAT finished with issues",
            "icon_emoji": ":x:"
        };

        const slackWebHook = 'https://hooks.slack.com/services/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' ;

        try {
            // make call to App Script
            await httpsRequest(options);
            // The console.log below will not run until the GET request above finishes
            console.log('Deleted old Backups for production completed successfully! ');
            // send notification to Slack
            console.log('Sending slack message');
            const messageBody = {
                "username": "Deleted Backup",
                "text": tmpMessage,
                "icon_emoji": ":heavy_check_mark:"
            };
            const slackResponse = await postToSlack(slackWebHook, messageBody);
            console.log(messageBody)
            console.log('Slack Message response', slackResponse);
            return callback(null, JSON.stringify(tmpMessage));

        } catch (e) {
            console.error('There was a error with the request', e);
            console.error('GET request failed, error:', e.message);
            const slackResponse = await postToSlack(slackWebHook, messageBodyError);
            console.log('Slack Message response', slackResponse);
            return callback(null, JSON.stringify(tmpMessage));
        }
    }