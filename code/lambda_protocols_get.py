from typing import Any, Dict, List, Optional
from pydantic import BaseModel, ValidationError
from aws_lambda_powertools.utilities.parser.models import EventBridgeModel
from aws_lambda_powertools.utilities.parser import event_parser
from aws_lambda_powertools.utilities.typing import LambdaContext
import json

class UserModel(BaseModel):
    username: str
    password1: str
    password2: str

class MyEventBridgeModel(EventBridgeModel):
    detail: UserModel

      
def lambda_handler(event: Dict[str, Optional[Any]], context: LambdaContext) -> None:
    try:
        parsed_event = MyEventBridgeModel(**event)
    except ValidationError as ex:
        # handle
        raise {
            'ErrorType': ex.errorType
        }

    user_model: UserModel = parsed_event.detail
    # start to process the parsed event
    response = {
        "account": user_model.username,
        "time": user_model.password1,
        "region": user_model.password2
    }
    return json.dumps(response)
    
#@event_parser(model=MyEventBridgeModel)
#def handle_eventbridge_with_decorator(event: MyEventBridgeModel, context: LambdaContext) -> None:
#    user_model: UserModel = event.detail
    
#def handle_eventbridge_with_parse(event: Dict[str, Optional[Any]], context: LambdaContext) -> None:
#    try:
#       parsed_event = parse(model=MyEventBridgeModel, event=event)
#    except ValidationError:
        # handle
#        return 
    
#    user_model: UserModel = parsed_event.detail

payload = {
    "version": "0",
    "id": "6a7e8feb-b491-4cf7-a9f1-bf3703467718",
    "detail-type": "CustomerSignedUp",
    "source": "CustomerService",
    "account": "111122223333",
    "time": "2020/10/22T18:43:48Z",
    "region": "us-west-1",
    "resources": ["some_additional_"],
    "detail": {
      "username": "universe",        
      "password1": "myp@ssword",        
      "password2": "repeat password"    
    }
}
