package main

import (
	"github.com/gin-gonic/gin"
	"github.com/yeencloud/ServiceCore"
	"net/http"
	"strconv"
)

func main() {
	service := servicecore.NewServiceClient()

	r := gin.Default()
	r.GET("/:A/:B", func(c *gin.Context) {
		A, stderr := strconv.ParseInt(c.Param("A"), 10, 64)
		if stderr != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"error": stderr.Error(),
			})
			return
		}
		B, stderr := strconv.ParseInt(c.Param("B"), 10, 64)
		if stderr != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"error": stderr.Error(),
			})
			return
		}

		data := service.Call("Arith", "Add", gin.H{
			"A": A,
			"B": B,
		})

		if data.Error != nil {
			c.JSON(data.Error.HttpCode, data)
			return
		}

		c.JSON(http.StatusOK, data)
	})
	r.Run()
}