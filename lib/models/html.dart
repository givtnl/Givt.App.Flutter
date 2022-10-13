class WepayHtml {
  static String body = """

<!DOCTYPE html>
<html>
<head>
    <script src='https://cdn.wepay.com/wepay.min.js'></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body style="background-color:#F5F5F5">
<!-- credit-card-iframe id will be the location for appending the credit card iframe -->
<div id="credit-card-iframe"style="height:500px"></div>
<div id="token"></div>
<script>

    const custom_style = {
    'styles': {
        '#credit-card #cvv .validator':{
'max-width':'!important inherit',
        },
        'base': {
            'color': '#2e2957',
            'height':'inherit',
            'padding':'8px',
            'background-color': '#F5F5F5',
            'border': '2px solid #184869',
            'border-radius': '15px',
            'font-weight': '400',
            'font-family': 'sans-serif',
            'font-size': '25px',
            
            ':focus': {
                'border': '1.8px solid #184869',
            },
            '::placeholder': {
                'text-transform': 'capitalize',
                'color': '#BCB9C8',
                'font-size': '25px',
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
    }
    };

    const options = {
        custom_style: custom_style,
        show_labels:false,
        show_placeholders:true,
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
