class WepayHtml {
  static String body = """

<!DOCTYPE html>
<html>
<head>
    <script src='https://cdn.wepay.com/wepay.min.js'></script>
    <style type="text/css">
        html {
            height: 100%;
        }

        body {
            text-align: center;
            margin: 10;
            box-sizing: border-box;
            height: 100%;
            display: flex;
            flex-direction: column;
            overflow: hidden !important;
            position: relative;
        }

    </style>
</head>
<body style="background-color:#FFFFFF">
<!-- credit-card-iframe id will be the location for appending the credit card iframe -->
<div id="credit-card-iframe"></div>
<div id="token"></div>
<script>

    const custom_style = {
    'styles': {
        'base': {
            'color': '#2e2957',
            'background-color': '#FFFFFF',
            'border': '1.3px solid #898989',
            'border-top': 'none',
            'border-right': 'none',
            'border-left': 'none',
            'font-weight': '400',
            'font-family': 'sans-serif',
            'font-size': '17px',
            'padding': '0px',
            ':focus': {
                'border': '1.8px solid #898989',
                'border-top': 'none',
                'border-right': 'none',
                'border-left': 'none'
            },
            '::placeholder': {
                'text-transform': 'capitalize',
                'color': '#BCB9C8',
                'font-size': '17px',
                'font-weight': '400'
            }
        },
        'invalid': {
            'color': '#2e2957',
            'border-color': '#F17057'
        },
        'valid': {
            'color': '#2e2957',
            'border-color': '#898989'
        },
        'labels': {
            'base': {
                'color': '#898989',
                'font-family': 'sans-serif',
                'font-size': '12px',
                'font-weight': '400',
                'text-transform': 'capitalize',
                'padding': '0px',
            },
            'invalid': {
                'color': '#F17057'
            }
        },
        'errors': {
            'invalid': {
                'color': '#CD5C5C'
            }
        },
        'cvv-icon': {
            'base': {
                 'display': 'none'
            }
        }
    }};

    const options = {
        custom_style: custom_style,
        show_labels:true,
        show_placeholders:false,
        show_error_messages:true,
        show_error_messages_when_unfocused:false
    };
    const appId = "537744";
    const apiVersion = "3.0";

    let error = WePay.configure("stage", appId, apiVersion);
    if (error) {
        console.log(error);
    };

    const iframe_container_id = "credit-card-iframe";
    let creditCard = WePay.createCreditCardIframe(iframe_container_id, options);

    function tokenize() {
        // creditcardIframeActivity.showLoading();
        console.log("tokenizing");
        creditCard.tokenize()
            .then(function(response) {
                console.log('response', JSON.stringify(response));
                //creditcardIframeActivity.processWePayResponse(JSON.stringify(response));
            })
            .catch(function(error) {
                //creditcardIframeActivity.showError(JSON.stringify(error))
                let key = error[0].target[0];
                creditCard.setFocus(key);
                console.log('error', JSON.stringify(error))
            });
    }
</script>
</body>
</html>
  """;
}
