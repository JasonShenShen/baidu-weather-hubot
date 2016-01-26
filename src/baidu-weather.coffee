# Description
#   A hubot script to report weather
#
#
# Commands:
#   hubot weather city

module.exports = (robot) ->
  robot.respond /weather (.*)/, (msg) ->
    city = msg.match[1]
    url_send = "http://apistore.baidu.com/microservice/weather?cityname=#{encodeURI(city)}"
    console.log(url_send)
    robot.http(url_send)
      .get() (err, res, body) ->
        data = JSON.parse(body)
        if data.retData.city?
          result = data.retData
          response = ""
          response += "小7提醒您 #{result.city}天气:  #{result.weather}\n"
          response += "时间：#{result.date} #{result.time} 温度: #{result.temp}\n"
          response += "高低: #{result.l_tmp} 至 #{result.h_tmp}\n"
          response += "风向: #{result.WD}\n"
          response += "风力: #{result.WS}\n"
          response += "日出: #{result.sunrise}\n"
          response += "日落: #{result.sunset}\n"
          msg.send response
        else
          msg.send "大笨蛋, #{city}你去过吗?"

