class WepayHtml {
  static String body = """

<!DOCTYPE html>
<html>
<head>
    <script src='https://cdn.wepay.com/wepay.min.js'></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Mulish">

</head>
<body style="background-color:#F5F5F5">
<!--<div style="font-family: Mulish;">Card number</div> -->
<!-- credit-card-iframe id will be the location for appending the credit card iframe -->
<div id="credit-card-iframe"style="font-family: Mulish;"></div>
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
            'padding':'12px',
            
            margin:'0px',
            'background-color': '#F5F5F5',
            'border': '1px solid #184869',
            'border-radius': '8px',
            'font-weight': '400',
            'font-family': "'Mulish'",
            'font-size': '16px',
            
            ':focus': {
                'border': '1px solid #184869',
            },
            '::placeholder': {
              'font-family': "'Mulish' !important",
                'text-transform': 'capitalize',
                'color': '#838383',
                'font-size': '16px',
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
