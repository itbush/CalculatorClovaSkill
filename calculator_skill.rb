require 'clova'

class CalculatorSkill < Clova::Skill
    def launch_request
    response.add_speech("数学しますか？")
    response.add_reprompt("待っています")
    response
    end

  def intent_request
    if request.session.session_attributes[:sum] != nil
      new_sum = request.find_slot_value_by(:num).to_i + request.session.session_attributes[:sum].to_i
      speech = "#{request.find_slot_value_by(:num)} + #{request.session.session_attributes[:sum]}　＝ #{new_sum}"
      puts speech
      response.add_speech(speech)
    else
      new_sum = request.find_slot_value_by(:num).to_i + request.find_slot_value_by(:numtwo).to_i
      speech = "#{request.find_slot_value_by(:num)} + #{request.find_slot_value_by(:numtwo)} ＝ #{new_sum}"
      puts speech
      response.add_speech(speech)
    end
    response.add_speech("も一つある？")
    response.add_session_attribute(key: "IntentName", value: "addition")
    response.add_session_attribute(key: "sum", value: new_sum.to_s)
    response
  end

  def handle_session_end
  end
end
